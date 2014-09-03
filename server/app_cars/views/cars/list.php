<div class="container">
    <div class="page-header">
      <h1>车辆管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				
				<div class="panel-heading" >					
					车辆列表（最近20位）
					<div class="input-group pull-right col-md-6">						
						<input type="text" class="form-control" id="keyword">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="do_search()">搜索</button>
						</span>
					</div><!-- /input-group -->
					<div style="clear: both"></div>
				</div>
		      
				<!-- Table -->
			  <table class="table">
		        <thead>
		          <tr><th>#</th><th>牌号</th><th>车系</th><th>款型</th><th><div class="pull-right"> 操作</div></th></tr>
		        </thead>

		        <tbody>

				<?php foreach ($cars as $item): ?>
		          <tr>
		            <td><?php echo $item["id"]; ?></td>
		            <td><?php echo anchor("cars/".$item["id"],$item["carnumber"],""); ?></td>
		            <td><?php echo $item['manufacturer']."-".$item['brand']; ?></td>
		            <td><?php echo $item['brand']; ?></td>
		            <td align=right>
				<?php link_to_edit("cars/".$item["id"]."/edit"); ?> |
				<?php link_to_jdelete("confirm_del(\"".$item["id"]."/jdelete\",\"".$item["carnumber"]."\")"); ?>
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
				<div class="panel-heading">增加车辆</div>				
				<div class="panel-body">
				    <?php
					zm_form_open('cars/save');
					zm_form_input(1,"牌照号码","carnumber");
					zm_form_textarea(1,"制造厂商","manufacturer");
					zm_form_textarea(1,"品牌系列","brand");
					zm_btn_submit("增 加");
				    ?>
				    </form>
				</div>
		    </div>
		</div>
    </div>


    <script type="text/javascript">
	    function do_search() {
		    var keyword=$("#keyword").val();
		    
		    //this will redirect us in same window
		    if (keyword.length>0){
			    document.location.href = "cars?search="+keyword;
		    } else {
			    alert( "搜索关键字无效");
		    }
		    
	    }
    </script>  

    <?php zm_dlg_delete(array("path"    => base_url("cars"),
			     "title1"  => "确认删除车辆信息",
			     "title2"  => "您确认要删除相关车辆信息吗?: ")); ?>


</div>


