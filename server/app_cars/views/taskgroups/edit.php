<div class="container">
    <div class="page-header">
      <h1>任务组管理 <small><?php echo $taskgroup["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑任务组</div>
        <div class="panel-body">            
            <?php
                zm_form_open('taskgroups/save',array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_hidden('item_id', $taskgroup["id"]);
                zm_form_input(0,"名 称","name",$taskgroup["name"]);
                zm_form_textarea(0,"说 明","descp",$taskgroup["descp"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保 存");
                    zm_btn_delete("删 除","confirm_del(".$taskgroup["id"].",\"".$taskgroup["name"]."\")");
                ?>
              </div>
            </div>
          </form>
        </div>
    </div>
    <?php zm_dlg_delete(array("path"    => base_url("taskgroups/"),
                          "title1"  => "确认删除任务组信息",
                          "title2"  => "任务组: ")); ?>
    
    <div class="panel panel-default">
        <div class="panel-heading" >任务关联</div>
        <div class="row">
            <div class="col-xs-4 col-xs-offset-2">
                已关联任务:
                <ul><?php foreach ($tasks1 as $item): ?>
                    <li><?= anchor("taskgroups/".$taskgroup["id"]."/unlink?return=1&rid=".$item["rid"],$item["rname"]) ?></li>
                <?php endforeach ?></ul>
            </div>
            <div class="col-xs-4">
                可选关联任务:
                <ul><?php foreach ($tasks2 as $item): ?>
                    <li><?= anchor("taskgroups/".$taskgroup["id"]."/link?return=1&rid=".$item["id"]."&rname=".$item["name"],$item["name"]) ?></li>
                <?php endforeach ?></ul>
            </div>
        </div>
    </div>
    <?php zm_btn_back("taskgroups"); ?>
</div>