# teched-platform

## AUTH Service
## Backend (Spring Boot): È configurato per essere Stateless e richiede una chiave JWT lunga e sicura per firmare i token.

## Next.js Proxy (next.config.js): Gestisce le chiamate "pubbliche" (come la richiesta dell'OTP) senza problemi di CORS.

## BFF Layer (api/login/route.ts): È il "caveau". Prende il token da Spring, lo chiude in un Cookie HttpOnly e dice al browser solo "Ok, sei dentro", senza mai mostrargli la chiave.

## Frontend (React): Fa il redirect alla pagina /corsi solo se il BFF conferma che il cookie è stato settato.

<img width="1081" height="1131" alt="diagramma-bozza" src="https://github.com/user-attachments/assets/1b66c6a7-0f89-4702-804d-2358cd1cfdd2" />
