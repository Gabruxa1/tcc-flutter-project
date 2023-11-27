const connection = require('./connection');

const getAll = async () => {
    const funcionarios = await connection.query('SELECT * FROM funcionarios');
    return funcionarios.rows
}

module.exports = {
    getAll
}