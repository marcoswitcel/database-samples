/**
 * @note https://www.mongodb.com/docs/v5.0/tutorial/write-scripts-for-the-mongo-shell/
 */

// Exemplo de execução desse script: mongo < script.js
use banco_de_pessoas;

db.pessoas.insertMany([
    { name: 'João', idade: 22},
    { name: 'Marcos', idade: 33}
]);
