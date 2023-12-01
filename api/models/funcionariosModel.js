const connection = require('./connection');

const getAll = async () => {
    const funcionarios = await connection.query('SELECT * FROM pesquisar_funcionarios()');
    return funcionarios.rows
}

const getActives = async () => {
    const funcionarios = await connection.query('SELECT * FROM pesquisar_funcionarios() WHERE ativo = TRUE');
    return funcionarios.rows
}
module.exports = {
    getAll,
    getActives
}