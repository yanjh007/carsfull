<?php
	$MODULE_PATH="dics/";
	$END_NUMBER=1000;
	//var_dump($type_list);
?>

<div class="container">
    <div class="page-header">
      <h1>字典管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
			<?php foreach ($dic_list as $item): ?>
				<?php if ($item["did"]==0): ?>
					<div class="panel panel-default">
					<div class="panel-heading" ><?php echo $item["dtype"].". ".$item["name"]; ?></div>
					<table class="table"><tbody>
					<?php echo zm_table_header("序号,代码,名称,说明","操作") ?>

				<?php elseif ($item["did"]==$END_NUMBER): ?>
					</tbody></table></div>
				<?php else:  ?>
					<tr>
					  <td class="col-md-1"><?php echo  $item["did"]; ?></td>
					  <td class="col-md-2"><?php echo  $item['dcode']; ?></td>
					  <td class="col-md-2"><?php echo  $item["name"]; ?></td>
					  <td class="col-md-3"><?php echo  $item["descp"]; ?></td>
					  <td align=right>
						<?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
					  </td>
					</tr>
				<?php endif ?>
			<?php endforeach ?>
        </div>

        <div class="col-md-4">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">增加项目</div>				
				<div class="panel-body">				
					<?php					    
					    zm_form_open(1,'dics/0/save');
					    zm_form_select(1,"类 型","dtype",$type_list);
					    zm_form_input(1,"次 序","did");
					    zm_form_input(1,"代 码","dcode");
					    zm_form_input(1,"标 题","name");
					    zm_form_input(1,"简单描述","descp");
					    zm_btn_submit("增 加");
					?>
					</form>
				</div>
		    </div>
		</div>
    </div>
</div>

<?php zm_dlg_delete(array("path" => base_url($MODULE_PATH),  "title1"  => "确认删除",  "title2"  => "删除内容: ")); ?>


