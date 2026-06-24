from fastapi import FastAPI, UploadFile, File, Form
from pydantic import BaseModel
from google import genai
from fastapi.middleware.cors import CORSMiddleware
import json

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 👈 libera tudo (dev)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 🔑 configure sua API KEY
client = genai.Client(api_key="")


class ConteudoRequest(BaseModel):
    conteudo: str
    quantidade: int = 5


def gerar_flashcards_ia(texto, quantidade):
    prompt = f"""
Crie exatamente {quantidade} flashcards.

Retorne APENAS JSON válido.
NÃO use ```json nem explicações.

Formato:
[
  {{"pergunta": "...", "resposta": "..."}}
]

Texto:
{texto}
"""

    response = client.interactions.create(
        model="gemini-2.5-flash-lite",
        input=prompt
    )

    conteudo = response.output_text

    # 🔥 limpa resposta do Gemini
    conteudo = conteudo.replace("```json", "").replace("```", "").strip()

    try:
        return json.loads(conteudo)
    except Exception as e:
        return {
            "erro": "Falha ao converter JSON",
            "raw": conteudo
        }


@app.post("/gerar-flashcards")
def gerar_flashcards(req: ConteudoRequest):
    return gerar_flashcards_ia(req.conteudo, req.quantidade)


@app.post("/gerar-flashcards-arquivo")
async def gerar_flashcards_arquivo(
    arquivo: UploadFile = File(...),
    quantidade: int = Form(...)
):
    conteudo = await arquivo.read()
    texto = conteudo.decode("utf-8", errors="ignore")

    return gerar_flashcards_ia(texto, quantidade)