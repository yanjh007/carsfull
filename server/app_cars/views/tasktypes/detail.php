<div class="container">
    <div class="page-header">
      <h1>店铺管理 <small><?php echo $shop["name"] ?></small></h1>
      
    </div>
    
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading " >基本信息</div>
                <br>
                <dl class="dl-horizontal" >
                    <dt>编 号</dt><dd><?=  $shop["scode"]?></dd>
                    <dt>名 称</dt><dd><?=  $shop["name"]?></dd>
                    <dt>地 址</dt><dd><?=  $shop["address"]?></dd>
                    <dt>联系方式</dt><dd><?= $shop["contact"]?></dd>
                </dl>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading" >相关客户</div>
                <br>
                <dl class="dl-horizontal" >
                </dl>
            </div>
    
        </div>
        <div class="col-md-4">
		<div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">关联用户</div>				
				<div class="panel-body">				
					<?= form_open('shops/link',array("role"=>"form")); ?>
                    <?= form_hidden('shop_id', $shop["id"]); ?>
                    <?= form_hidden('shop_name', $shop["name"]); ?>
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
