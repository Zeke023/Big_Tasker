from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    session
)

from dotenv import load_dotenv

from database.connection import criar_conexao

import bcrypt
import os

# =========================
# CARREGA .ENV
# =========================
load_dotenv()

# =========================
# INICIALIZA FLASK
# =========================
app = Flask(__name__)

# Chave da sessão
app.secret_key = os.getenv("SECRET_KEY")


# =========================
# LOGIN
# =========================
@app.route("/", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        email = request.form["email"]
        senha = request.form["senha"]

        conexao = criar_conexao()

        cursor = conexao.cursor()

        cursor.execute(
            """
            SELECT * FROM usuarios
            WHERE email = %s
            """,
            (email,)
        )

        usuario = cursor.fetchone()

        cursor.close()
        conexao.close()

        if usuario:

            # senha agora está no índice 4
            senha_hash = usuario[4]

            if bcrypt.checkpw(
                senha.encode("utf-8"),
                senha_hash.encode("utf-8")
            ):

                # cria sessão
                session["usuario"] = usuario[2]
                session["id_usuario"] = usuario[0]

                return redirect(url_for("dashboard"))

            else:
                return "Senha incorreta!"

        else:
            return "Usuário não encontrado!"

    return render_template("login.html")


# =========================
# CADASTRO
# =========================
@app.route("/cadastro", methods=["GET", "POST"])
def cadastro():

    if request.method == "POST":

        nome = request.form["nome"]
        email = request.form["email"]
        senha = request.form["senha"]

        # gera hash da senha
        senha_hash = bcrypt.hashpw(
            senha.encode("utf-8"),
            bcrypt.gensalt()
        ).decode("utf-8")

        conexao = criar_conexao()

        cursor = conexao.cursor()

        cursor.execute(
            """
            INSERT INTO usuarios
            (
                id_nivel,
                nome,
                email,
                senha,
                score,
                xp_total
            )
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (
                1,
                nome,
                email,
                senha_hash,
                0,
                0
            )
        )

        conexao.commit()

        cursor.close()
        conexao.close()

        return redirect(url_for("login"))

    return render_template("cadastro.html")


# =========================
# DASHBOARD
# =========================
@app.route("/dashboard")
def dashboard():

    # verifica sessão
    if "usuario" not in session:
        return redirect(url_for("login"))

    conexao = criar_conexao()

    cursor = conexao.cursor()

    # ====================================
    # VERIFICA TAREFAS ATRASADAS
    # ====================================

    cursor.execute(
        """
        UPDATE tarefas
        SET esta_atrasada = TRUE
        WHERE
            prazo < NOW()
        AND
            status != %s
        AND
            id_usuario = %s
        """,
        (
            "concluida",
            session["id_usuario"]
        )
    )

    conexao.commit()

    # ====================================
    # BUSCA DADOS USUÁRIO + NÍVEL
    # ====================================

    cursor.execute(
        """
        SELECT
            usuarios.nome,
            usuarios.xp_total,
            niveis.nome
        FROM usuarios

        JOIN niveis
            ON usuarios.id_nivel = niveis.id

        WHERE usuarios.id = %s
        """,
        (session["id_usuario"],)
    )

    dados_usuario = cursor.fetchone()

    # ====================================
    # BUSCA TAREFAS
    # ====================================

    cursor.execute(
        """
        SELECT *
        FROM tarefas
        WHERE id_usuario = %s
        ORDER BY data_criacao DESC
        """,
        (session["id_usuario"],)
    )

    tarefas = cursor.fetchall()

    cursor.close()
    conexao.close()

    return render_template(
        "dashboard.html",
        usuario=dados_usuario,
        tarefas=tarefas
    )


# =========================
# CRIAR TAREFAS
# =========================
@app.route("/criar_tarefa", methods=["POST"])
def criar_tarefa():

    # verifica sessão
    if "usuario" not in session:
        return redirect(url_for("login"))

    # captura dados formulário
    titulo = request.form["titulo"]
    descricao = request.form["descricao"]
    prazo = request.form["prazo"]
    dificuldade = request.form["dificuldade"]
    id_categoria = request.form["categoria"]

    # ====================================
    # DEFINE XP BASE PELA DIFICULDADE
    # ====================================

    if dificuldade == "facil":
        xp_base = 10

    elif dificuldade == "medio":
        xp_base = 25

    elif dificuldade == "dificil":
        xp_base = 50

    else:
        xp_base = 0

    # inicialmente xp final = xp base
    xp_final = xp_base

    # ====================================
    # CONEXÃO BANCO
    # ====================================

    conexao = criar_conexao()

    cursor = conexao.cursor()

    # ====================================
    # INSERT TAREFA
    # ====================================

    cursor.execute(
        """
        INSERT INTO tarefas
        (
            id_usuario,
            id_categoria,
            titulo,
            descricao,
            prazo,
            dificuldade,
            status,
            xp_base,
            xp_final,
            esta_atrasada
        )
        VALUES
        (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """,
        (
            session["id_usuario"],
            id_categoria,
            titulo,
            descricao,
            prazo,
            dificuldade,
            "pendente",
            xp_base,
            xp_final,
            False
        )
    )

    conexao.commit()

    cursor.close()
    conexao.close()

    return redirect(url_for("dashboard"))


# =========================
# EXCLUIR TAREFAS
# =========================
@app.route("/excluir_tarefa/<int:id_tarefa>")
def excluir_tarefa(id_tarefa):

    # verifica sessão
    if "usuario" not in session:
        return redirect(url_for("login"))

    conexao = criar_conexao()

    cursor = conexao.cursor()

    # exclui apenas tarefa do usuário logado
    cursor.execute(
        """
        DELETE FROM tarefas
        WHERE id = %s
        AND id_usuario = %s
        """,
        (
            id_tarefa,
            session["id_usuario"]
        )
    )

    conexao.commit()

    cursor.close()
    conexao.close()

    return redirect(url_for("dashboard"))


# =========================
# EDITAR TAREFAS
# =========================
@app.route("/editar_tarefa/<int:id_tarefa>", methods=["GET", "POST"])
def editar_tarefa(id_tarefa):

    # verifica sessão
    if "usuario" not in session:
        return redirect(url_for("login"))

    conexao = criar_conexao()

    cursor = conexao.cursor()

    # ====================================
    # SE FOR POST → SALVAR ALTERAÇÕES
    # ====================================

    if request.method == "POST":

        titulo = request.form["titulo"]
        descricao = request.form["descricao"]
        prazo = request.form["prazo"]
        dificuldade = request.form["dificuldade"]

        cursor.execute(
            """
            UPDATE tarefas
            SET
                titulo = %s,
                descricao = %s,
                prazo = %s,
                dificuldade = %s,
                ultima_atualizacao = NOW()
            WHERE
                id = %s
            AND
                id_usuario = %s
            """,
            (
                titulo,
                descricao,
                prazo,
                dificuldade,
                id_tarefa,
                session["id_usuario"]
            )
        )

        conexao.commit()

        cursor.close()
        conexao.close()

        return redirect(url_for("dashboard"))

    # ====================================
    # SE FOR GET → MOSTRAR FORMULÁRIO
    # ====================================

    cursor.execute(
        """
        SELECT *
        FROM tarefas
        WHERE id = %s
        AND id_usuario = %s
        """,
        (
            id_tarefa,
            session["id_usuario"]
        )
    )

    tarefa = cursor.fetchone()

    # ====================================
    # VERIFICA SE TAREFA ESTÁ CONCLUÍDA
    # ====================================

    if tarefa[7] == "concluida":

        cursor.close()
        conexao.close()

        return redirect(url_for("dashboard"))

    cursor.close()
    conexao.close()

    return render_template(
        "editar_tarefa.html",
        tarefa=tarefa
    )


# =========================
# CONCLUIR TAREFAS
# =========================
@app.route("/concluir_tarefa/<int:id_tarefa>")
def concluir_tarefa(id_tarefa):

    # verifica sessão
    if "usuario" not in session:
        return redirect(url_for("login"))

    conexao = criar_conexao()

    cursor = conexao.cursor()

    # ====================================
    # BUSCA TAREFA
    # ====================================

    cursor.execute(
        """
        SELECT status, xp_final
        FROM tarefas
        WHERE id = %s
        AND id_usuario = %s
        """,
        (
            id_tarefa,
            session["id_usuario"]
        )
    )

    tarefa = cursor.fetchone()

    # se tarefa não existir
    if not tarefa:

        cursor.close()
        conexao.close()

        return redirect(url_for("dashboard"))

    status = tarefa[0]
    xp_final = tarefa[1]

    # ====================================
    # EVITA XP DUPLICADO
    # ====================================

    if status == "concluida":

        cursor.close()
        conexao.close()

        return redirect(url_for("dashboard"))

    # ====================================
    # CONCLUI TAREFA
    # ====================================

    cursor.execute(
        """
        UPDATE tarefas
        SET
            status = %s,
            data_conclusao = NOW()
        WHERE
            id = %s
        """,
        (
            "concluida",
            id_tarefa
        )
    )

    # ====================================
    # ADICIONA XP AO USUÁRIO
    # ====================================

    cursor.execute(
        """
        UPDATE usuarios
        SET xp_total = xp_total + %s
        WHERE id = %s
        """,
        (
            xp_final,
            session["id_usuario"]
        )
    )

    # ====================================
    # BUSCA XP TOTAL ATUALIZADO
    # ====================================

    cursor.execute(
        """
        SELECT xp_total
        FROM usuarios
        WHERE id = %s
        """,
        (session["id_usuario"],)
    )

    xp_usuario = cursor.fetchone()[0]

    # ====================================
    # BUSCA NÍVEL CORRETO
    # ====================================

    cursor.execute(
        """
        SELECT id
        FROM niveis
        WHERE %s BETWEEN xp_minimo AND xp_maximo
        """,
        (xp_usuario,)
    )

    nivel = cursor.fetchone()

    # ====================================
    # ATUALIZA NÍVEL USUÁRIO
    # ====================================

    if nivel:

        id_nivel = nivel[0]

        cursor.execute(
            """
            UPDATE usuarios
            SET id_nivel = %s
            WHERE id = %s
            """,
            (
                id_nivel,
                session["id_usuario"]
            )
        )

    conexao.commit()

    cursor.close()
    conexao.close()

    return redirect(url_for("dashboard"))


# =========================
# RANKING
# =========================
@app.route("/ranking")
def ranking():

    # verifica sessão
    if "usuario" not in session:
        return redirect(url_for("login"))

    conexao = criar_conexao()

    cursor = conexao.cursor()

    # ====================================
    # BUSCA RANKING USUÁRIOS
    # ====================================

    cursor.execute(
        """
        SELECT
            usuarios.nome,
            usuarios.xp_total,
            niveis.nome

        FROM usuarios

        JOIN niveis
            ON usuarios.id_nivel = niveis.id

        ORDER BY usuarios.xp_total DESC
        """
    )

    ranking_usuarios = cursor.fetchall()

    cursor.close()
    conexao.close()

    return render_template(
        "ranking.html",
        ranking=ranking_usuarios
    )


# =========================
# LOGOUT
# =========================
@app.route("/logout")
def logout():

    session.clear()

    return redirect(url_for("login"))


# =========================
# TESTE BANCO
# =========================
@app.route("/teste_db")
def teste_db():

    conexao = criar_conexao()

    cursor = conexao.cursor()

    cursor.execute("SELECT * FROM usuarios")

    usuarios = cursor.fetchall()

    cursor.close()
    conexao.close()

    return str(usuarios)


# =========================
# INICIALIZAÇÃO
# =========================
if __name__ == "__main__":
    app.run(debug=True)