<?php
    $MODULE_PATH ="interviews/";
?>
<div class="container">
    <div class="page-header">
      <h1>测试结果
      <small><?php echo $examtitle ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"></div>
        <div class="panel-body">
            <dl class="dl-horizontal">
                <dt>测试时间</dt>
                <dd><?php echo date("m-d H:i",$status["itime"]*60); ?></dd>
                <dt>状 态</dt>
                <dd><?php echo $statuslist[$status["flag"]]; ?></dd>
                <dt>得 分</dt>
                <dd><?php echo $status["score"] ?></dd>
                <dt>注 解</dt>
                <dd><?php echo $status["answer"] ?></dd>
            </dl>
        </div>
    </div>
    <?php zm_btn_link("退出","interviews/logout"); ?>
</div>