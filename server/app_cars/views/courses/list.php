<?php
    $MODULE_PATH="courses/";
?>
<div class="container">
    <div class="page-header">
      <h1>课程管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading" >课程列表</div>
	      
		<!-- Table -->
		<table class="table">
		    <?php echo zm_table_header("#,编号,科目,名称","操作") ?>
		    <tbody>
		    <?php foreach ($itemlist as $item): ?>
			    <tr>
				  <td><?php echo  $item["id"]; ?></td>
				  <td><?php echo  $item['ccode']; ?></td>
				  <td><?php if (isset($ccata_list[$item["ccata"]])) echo $ccata_list[$item["ccata"]]; ?></td>
				  <td><?php echo  $item["name"]; ?></td>
				  <td align=right>
				  <?php echo anchor($MODULE_PATH.$item["id"]."/sclass","班级<span class='badge'>".(isset($countlist[$item["id"]])?$countlist[$item["id"]]:0)."</span>"); ?> |
				  <?php echo anchor($MODULE_PATH.$item["id"]."/plan","计划"); ?> |
				  <?php echo anchor($MODULE_PATH.$item["id"]."/edit","编辑"); ?>
				  </td>
			    </tr>
		    <?php endforeach ?>
		</tbody>
	      </table>
	    </div>

        </div>
        
        <div class="col-md-4">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加课程</div>				
		<div class="panel-body">
			<?php
			    zm_form_open(1,$MODULE_PATH."0/save");
			    zm_form_select(1,"科 目","ccata",$ccata_list,0);
			    zm_form_input(1,"代 码","ccode");
			    zm_form_input(1,"名 称","name");
			    zm_btn_submit("增加课程");
			?>
			</form>
		</div>
	    </div>
	</div>
    </div>

</div>


