const getRandom = (list) => list[Math.floor(Math.random() * list.length)];
const lines = +process.argv?.[2] ?? 100;

let t_counter = 3;
console.log(`
DROP TABLE IF EXISTS Schedule;
CREATE TABLE Schedule (
  \`time\` int(11) NOT NULL,
  \`#t\` int(11)   NOT NULL,
  \`op\` char(1)   NOT NULL,
  \`attr\` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO Schedule (\`time\`, \`#t\`, \`op\`, \`attr\`) VALUES
`);

let transactions = [1, 2];
const uncommited_transactions = new Set();

const actions = ['R', 'W'];
const attrs = ['A', 'B'];

[...Array(lines)].forEach((_, time) => {
	if (Math.random() >= 0.3 || transactions.length === 0) {
		transactions.push(t_counter++);
	}

	const transaction = getRandom(transactions);
	const action = getRandom(actions);

	console.log(
		`(${time + 1}, ${transaction}, '${action}', '${
			action === 'C' ? '' : getRandom(attrs)
		}'),`
	);
	uncommited_transactions.add(transaction);

	if (action === 'C') {
		transactions = transactions.filter((t) => t !== transaction);
		uncommited_transactions.delete(transaction);
	}
});

[...uncommited_transactions].forEach((transaction, index, {length}) => {
		console.log(
			`(${lines + index + 1}, ${transaction}, 'C', '')${
				index === length - 1 ? ';' : ','
			}`
		);
});
