const connection = require('./connection');

const getAll = async () => {
	const funcionarios = await connection.query('SELECT pes.nome AS nome, pes.cpf, pes.telefone, func.email, func.senha, func.funcao, func.admin, func.ativo, func.custo_hora FROM funcionarios func JOIN pessoas pes ON func.pessoa_id = pes.id;');
	return funcionarios.rows;
};

const getActives = async () => {
	const funcionarios = await connection.query('SELECT pes.nome AS nome, pes.cpf, pes.telefone, func.email, func.senha, func.funcao, func.admin, func.ativo, func.custo_hora FROM funcionarios func JOIN pessoas pes ON func.pessoa_id = pes.id WHERE func.ativo = TRUE;');
	return funcionarios.rows;
};

const createEmployee = async (employee) => {
	const {
		nome,
		cpf,
		telefone,
		email,
		senha,
		funcao,
		admin,
		ativo,
		custo_hora
	} = employee;

	const query = 'SELECT inserir_pessoa_funcionario($1, $2, $3, $4, $5, $6, $7, $8, $9) as id_pessoa';
	const createdEmployee = await connection.query(query, [nome, cpf, telefone, email, senha, funcao, admin, ativo, custo_hora]);
	const id_pessoa = createdEmployee.rows[0]?.id_pessoa;
	return { id_pessoa };
};

const deleteEmployee = async (id) => {
	const removedEmployee = await connection.query('DELETE FROM pessoas WHERE id = $1', [id]);
	return removedEmployee;
}


const updateEmployee = async (id, employee) => {
	try {
		const pessoaFields = ['nome', 'cpf', 'telefone'];
		const funcionarioFields = ['email', 'senha', 'funcao', 'admin', 'ativo', 'custo_hora'];

		const updatePessoaFields = pessoaFields.reduce((acc, field) => {
			if (employee[field] !== undefined && employee[field] !== null && employee[field] !== '') {
				acc[field] = employee[field];
			}
			return acc;
		}, {});

		const updateFuncionarioFields = funcionarioFields.reduce((acc, field) => {
			if (employee[field] !== undefined && employee[field] !== null && employee[field] !== '') {
				acc[field] = employee[field];
			}
			return acc;
		}, {});

		const updatePessoaValues = Object.values(updatePessoaFields);
		const updateFuncionarioValues = Object.values(updateFuncionarioFields);

		if (updatePessoaValues.length > 0) {
			const updatePessoaQuery = `
							UPDATE pessoas
							SET ${Object.keys(updatePessoaFields).map((col, index) => `${col} = $${index + 1}`).join(', ')}
							WHERE id = $${updatePessoaValues.length + 1}
					`;
			await connection.query(updatePessoaQuery, [...updatePessoaValues, id]);
		}

		if (updateFuncionarioValues.length > 0) {
			const updateFuncionarioQuery = `
							UPDATE funcionarios
							SET ${Object.keys(updateFuncionarioFields).map((col, index) => `${col} = $${index + 1}`).join(', ')}
							WHERE pessoa_id = $${updateFuncionarioValues.length + 1}
					`;
			await connection.query(updateFuncionarioQuery, [...updateFuncionarioValues, id]);
		}

		const updatedEmployeeQuery = `
					SELECT pes.nome AS nome, pes.cpf, pes.telefone, func.email, func.senha, func.funcao, func.admin, func.ativo, func.custo_hora
					FROM funcionarios func
					JOIN pessoas pes ON func.pessoa_id = pes.id
					WHERE pes.id = $1
			`;

		// Executando a consulta para obter os dados atualizados
		const { rows } = await connection.query(updatedEmployeeQuery, [id]);
		const updatedEmployee = rows[0];

		return updatedEmployee; // Retorna os dados do funcionário atualizado
	} catch (error) {
		throw error;
	}
};



const checkDuplicateByEmail = async (email) => {
	try {
		const query = `
					SELECT func.ativo
					FROM funcionarios func
					JOIN pessoas pes ON func.pessoa_id = pes.id
					WHERE func.email = $1;
			`;
		const result = await connection.query(query, [email]);

		if (result.rows.length > 0) {
			const isActive = result.rows[0].ativo;
			return isActive; // Retorna true se o funcionário estiver ativo
		}
		return false; // Retorna false se o e-mail não estiver cadastrado
	} catch (error) {
		throw error;
	}
};

const checkDuplicateByCPF = async (cpf) => {
	try {
		const query = `
					SELECT func.ativo
					FROM funcionarios func
					JOIN pessoas pes ON func.pessoa_id = pes.id
					WHERE pes.cpf = $1;
			`;
		const result = await connection.query(query, [cpf]);

		if (result.rows.length > 0) {
			const isActive = result.rows[0].ativo;
			return isActive;
		}
		return false;
	} catch (error) {
		throw error;
	}
};

module.exports = {
	getAll,
	getActives,
	createEmployee,
	deleteEmployee,
	updateEmployee,
	checkDuplicateByEmail,
	checkDuplicateByCPF
};
