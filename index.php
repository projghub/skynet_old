<?
	include("includes/class.standard.php");
	include("includes/class.sql.php");

	if(isset($_GET['reset']))
	{
		$sql = "truncate table benchmarks";
		$db->query($sql);
		header('Location: /');
		exit();
	}

	$sql = "select min(load_time) as min_load_time, max(load_time) as max_load_time, avg(load_time) as avg_load_time, count(*) as ad_loads from benchmarks";
	$benchmark = $db->get_row($sql);
?>
<table border="1">
	<tr>
		<td>Ad Loads</td>
		<td><?php echo $benchmark->ad_loads; ?></td>
	</tr>
	<tr>
		<td>Per Second</td>
		<td><?php echo number_format(1 / $benchmark->avg_load_time, 2); ?></td>
	</tr>
	<tr>
		<td>Avg Load Time</td>
		<td><?php echo $benchmark->avg_load_time; ?></td>
	</tr>
	<tr>
		<td>Min Load Time</td>
		<td><?php echo $benchmark->min_load_time; ?></td>
	</tr>
	<tr>
		<td>Max Load Time</td>
		<td><?php echo $benchmark->max_load_time; ?></td>
	</tr>
</table>
<a href="?reset">Reset</a>
<script type="text/javascript">//setTimeout("location.reload(true)", 1000)</script>
