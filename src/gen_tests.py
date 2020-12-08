from random import randint as randint

def rand_elem(lista):
    return lista[randint(0, len(lista)-1)]

n_comandos = 4
attrs = ['X', 'Y']
trans = [1, 2]
op    = ['W', 'R']
comando = "({}, {}, '{}', '{}')"

header = '''
DROP TABLE IF EXISTS `Schedule`;
CREATE TABLE `Schedule` (
  `time` int(11) NOT NULL,
  `#t`   int(11) NOT NULL,
  `op`   char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
'''

rows = []
for i in range(n_comandos):
    rows.append(comando.format(i, rand_elem(trans), rand_elem(op), rand_elem(attrs)))

for i in range(len(trans)):
    rows.append(comando.format(i+n_comandos, trans[i], 'C', ''))

print(header)
print(*rows, sep=',\n', end=';')
