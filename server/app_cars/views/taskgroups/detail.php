<div class="container">
    <div class="page-header">
      <h1>任务组管理 <small><?php echo $taskgroup["name"] ?></small></h1>
      
    </div>
    
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading " >基本信息</div>
                <br>
                <dl class="dl-horizontal" >
                    <dt>名 称</dt><dd><?=  $taskgroup["name"]?></dd>
                    <dt>描 述</dt><dd><?=  $taskgroup["descp"]?></dd>
                </dl>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading" >任务关联</div>
                <div class="row">
					<div class="col-xs-5 col-xs-offset-2">
						已关联任务:
						<ul><?php foreach ($tasks1 as $item): ?>
							<li><?= anchor("taskgroups/".$taskgroup["id"]."/unlink?rid=".$item["rid"],$item["rname"]) ?></li>
						<?php endforeach ?></ul>
					</div>
					<div class="col-xs-5">
						可选关联任务:
						<ul><?php foreach ($tasks2 as $item): ?>
							<li><?= anchor("taskgroups/".$taskgroup["id"]."/link?rid=".$item["id"]."&rname=".$item["name"],$item["name"]) ?></li>
						<?php endforeach ?></ul>
					</div>
				</div>
            </div>
    
        </div>

    </div>
    
    <button class="btn btn-default" type="button" id="btn_back" onclick="javascript:document.location.href = 'taskgroups/'">返 回</button>

</div>
