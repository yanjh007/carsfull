<div class="container">
    <div class="page-header">
      <h1>型号管理 <small><?php echo $carmodel["mcode"] ?></small></h1>
      
    </div>
    
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading " >基本信息</div>
                <br>
                <dl class="dl-horizontal" >
                    <dt>型号编码</dt><dd><?=  $carmodel["mcode"]?></dd>
                    <dt>型号名称</dt><dd><?=  $carmodel["mname"]?></dd>
                    <dt>厂 商</dt><dd><?=  $carmodel["manufacturer"]?></dd>
                    <dt>品 牌</dt><dd><?= $carmodel["brand"]?></dd>
                </dl>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading" >相关信息</div>
                <br>
                <dl class="dl-horizontal" >
                </dl>
            </div>
    
        </div>

    </div>
    
    <?php zm_btn_back("'carmodels/'") ?>

</div>
