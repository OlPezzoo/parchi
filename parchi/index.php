<!DOCTYPE html>
<html>
<head>
	<style>
		body {
  			font-family: Arial, Helvetica, sans-serif;
		}

		table, th, td {
  			border: 1px solid black;
		}
	</style>
	<title>Parchi nazionali</title>
	<h1>Parchi nazionali</h1>
</head>
<body>
	<form method="GET" action="index.php">
		<?php
			function conn(&$connection) {
				$ip = '127.0.0.1';
				$username = 'root';
				$pwd = '';
				$database = 'parchi';
				$connection = new mysqli($ip, $username, $pwd, $database);

				//connessione al database
				if ($connection->connect_error) {
					die('Si e\' verificato un errore: ' . $connection->connect_error);
				}
				//il database è collegato
			}
			function task($qry, $tableName, $fk, $select_id, $col) {
				conn($c);
				$sql = $qry;
				$result = $c->query($sql);
				if ($result->num_rows > 0) {
					echo '<label>' . $tableName . ':</label>
						<select name="select_' . $fk . '" id="' . $select_id . '">';
					//inserisco i vari campi cercati e li inserisco in un array associativo
					while ($row = $result->fetch_assoc()) {
						echo '<option value="' . $row[$fk] . '">' . $row[$col] . '</option>';
					}
				echo '</select>
				<input type="submit" />';
				}
			}
			
			//REGIONE
			task('SELECT idRegione, nomeRegione FROM regione', 'Regione', 'idRegione', 'regioni', 'nomeRegione');
			echo '<br><br>';
			//PARCO
			if (isset($_REQUEST['select_idRegione'])) {
				task('SELECT idParco, nomeParco FROM parco WHERE idRegione="' . $_REQUEST['select_idRegione'] . '"', 'Parco', 'idParco', 'parchi', 'nomeParco');
			}
			echo '<br><br>';
			//SPECIE
			if (isset($_REQUEST['select_idParco'])) {
				task('SELECT idSpecie, nomeSpecie FROM specie WHERE idParco="' . $_REQUEST['select_idParco'] . '"', 'Specie', 'idSpecie', 'specie', 'nomeSpecie');
			}
			echo '<br><br>';
			//ANIMALE
			if (isset($_REQUEST['select_idSpecie'])) {
				echo '<h4>Elenco animali</h4>
				<p>Numero animali: ';
				conn($c1);
				$sql1 = 'SELECT COUNT(*) FROM animale WHERE idSpecie=' . $_REQUEST['select_idSpecie'];
				$rNumAnimali = $c1->query($sql1);
				if ($rNumAnimali->num_rows > 0) {
					while ($row = $rNumAnimali->fetch_assoc()) {
						echo $row['COUNT(*)'] . '</p>';
					}
				}

				echo '<p>Età media animali: ';
				conn($c2);
				$sql2 = 'SELECT ROUND((AVG(YEAR(NOW()) - YEAR(dataNascita))), 2) as etaMedia FROM animale WHERE idSpecie=' . $_REQUEST['select_idSpecie'];
				$rEtaMedia = $c2->query($sql2);
				if ($rEtaMedia->num_rows > 0) {
					while ($row = $rEtaMedia->fetch_assoc()) {
						echo $row['etaMedia'] . '</p>';
					}
				}

				echo '<table id="tabAnimali" style="width:50%">
				<tr>
					<th>#</th>
					<th>Nome</th>
					<th>Data nascita</th>
					<th>Sesso</th>
					<th>Stato salute</th>
				</tr>';

				conn($c3);
				$sql3 = 'SELECT idAnimale, nomeAnimale, dataNascita, sesso, statoSalute FROM animale WHERE idSpecie=' . $_REQUEST['select_idSpecie'];
				$rTabAnimali = $c3->query($sql3);
				if ($rTabAnimali->num_rows > 0) {
					while ($row = $rTabAnimali->fetch_assoc()) {
						echo '<tr>
						<td>' . $row['idAnimale'] . '</td>
						<td>' . $row['nomeAnimale'] . '</td>
						<td>' . $row['dataNascita'] . '</td>
						<td>' . $row['sesso'] . '</td>
						<td>' . $row['statoSalute'] . '</td>
						</tr>';
					}
				}
				echo '</table>';
			}
		?>
	</form>
</body>
</html>