<div class="container">
    <div class="page-header">
      <h1>车辆管理 <small><?php echo $car["carnumber"] ?></small></h1>
    </div>
    
    <div class="row">
    <div class="col-md-8">
        <div class="panel panel-default">
            <div class="panel-heading " >基本信息</div>
            <br>
            <dl class="dl-horizontal" >
                <dt>牌照号码</dt><dd><?=  $car["carnumber"]?></dd>
                <dt>制造厂商</dt><dd><?=  $car["manufacturer"]?></dd>
                <dt>品牌系列</dt><dd><?=  $car["brand"]?></dd>
            </dl>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading" >客户信息</div>
            <br>
            <dl class="dl-horizontal" >
            </dl>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading" >维护信息</div>
            <br>
            <dl class="dl-horizontal" >
            </dl>
        </div>

    </div></div>
    
    <button class="btn btn-default" type="button" id="btn_back" onclick="javascript:history.back()">返 回</button>

</div>
