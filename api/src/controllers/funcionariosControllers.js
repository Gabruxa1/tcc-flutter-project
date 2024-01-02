const funcionariosModel = require('../../models/funcionariosModel');


const getAll = async (_request, response) => {
	try {
		const funcionarios = await funcionariosModel.getAll();
		return response.status(200).json(funcionarios);
	} catch (error) {
		return response.status(500).json({ error: 'Erro ao obter todos os funcionários.' });
	}
};

const getActives = async (_request, response) => {
	try {
		const funcionarios = await funcionariosModel.getActives();
		return response.status(200).json(funcionarios);
	} catch (error) {
		return response.status(500).json({ error: 'Erro ao obter funcionários ativos.' });
	}
};

const createEmployee = async (request, response) => {
	try {
		const createdEmployee = await funcionariosModel.createEmployee(request.body);
		return response.status(201).json(createdEmployee);
	} catch (error) {
		return response.status(500).json({ error: 'Erro ao criar um novo funcionário.' });
	}
};

const deleteEmployee = async (request, response) => {
	const { id } = request.params;
	await funcionariosModel.deleteEmployee(id);
	return response.status(204).json();
}

const updateEmployee = async (request, response) => {
	try {
		const { id } = request.params;
		const updatedData = request.body;

		const updatedEmployee = await funcionariosModel.updateEmployee(id, updatedData);

		return response.status(200).json(updatedEmployee);
	} catch (error) {
		return response.status(500).json({ error: 'Erro ao atualizar funcionário.' });
	}
};



module.exports = {
	getAll,
	getActives,
	createEmployee,
	deleteEmployee,
	updateEmployee
};
