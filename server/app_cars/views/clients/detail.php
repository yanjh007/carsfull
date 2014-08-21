<div class="container">
    <div class="page-header">
      <h1>客户管理 <small><?php echo $client["name"] ?></small></h1>
      
    </div>
    
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading " >基本信息</div>
                <br>
                <dl class="dl-horizontal" >
                    <dt>名 称</dt><dd><?=  $client["name"]?></dd>
                    <dt>手 机</dt><dd><?=  $client["mobile"]?></dd>
                    <dt>IM方式</dt><dd><?= $client["wechat"]?></dd>
                </dl>
            </div>
            
            <?php
            foreach ($cars as $item): ?>
            <div class="panel panel-default">
                <div class="panel-heading" >车辆信息: <?= $item["rname"] ?></div>
                <br>
                <dl class="dl-horizontal" >
                    <dt>厂商品牌</dt><dd><?=  $item["manufacturer"]."-".$item["brand"]?></dd>
                    <dt>型号配置</dt><dd><?=  $item["model"]."-".$item["modelname"]; ?></dd>
                </dl>
                
                <div class="panel-footer"></div>
            </div>
            <?php endforeach ?>
    
            <div class="panel panel-default">
                <div class="panel-heading" >关联客户</div>
                <br>
                <dl class="dl-horizontal" >

                </dl>
            </div>
    
        </div>
        <div class="col-md-4">
		<div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">关联车辆</div>				
				<div class="panel-body">				
					<?= form_open('clients/link',array("role"=>"form")); ?>
                    <?= form_hidden('client_id', $client["id"]); ?>
                    <?= form_hidden('client_name', $client["name"]); ?>
					<div class="form-group">
					  <label for="exampleInputEmail1">牌照号码</label>
					  <?= form_input(array( 'name'  => 'carnumber',
											'id'    => 'carnumber',
											'class' => 'form-control',
												)); ?>
					</div>

					<button type="submit" class="btn btn-primary">关 联</button>
					</form>
				</div>
		</div></div>
    </div>
    
    <button class="btn btn-default" type="button" id="btn_back" onclick="javascript:history.back()">返 回</button>

</div>
