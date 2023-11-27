const funcionariosModel = require ('../models/funcionariosModel')

const getAll = async (request, response) => {
    const funcionarios = await funcionariosModel.getAll();
    return response.status(200).json(funcionarios);
}
module.exports = {
    getAll
}