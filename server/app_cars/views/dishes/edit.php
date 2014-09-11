<div class="container">
    <div class="page-header">
      <h1><?php
            echo $item["dtype"]==0?"单品编辑":"套餐编辑";
      ?>
      <small><?php echo $item["name"]; ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">基本信息</div>
        <div class="panel-body">
            <?php
                echo form_open("dishes/".$item["id"]."/save",array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_input(0,"编 码","dcode", $item["dcode"]);
                zm_form_input(0,"名 称","name",  $item["name"]);
                zm_form_input(0,"价 格","price", $item["price"]);
                zm_form_input(0,"描 述","descp", $item["descp"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php  zm_btn_submit("保 存"); ?>
              </div>
            </div>
          </form>
        </div>

        
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">单品分类</div>
        <div class="panel-body">
        <div class="row">
            <div class="col-md-4">已属分类<br>
                <ul><?php
                    if ($links0) foreach ($links0 as $item1) {
                        echo "<li>".anchor(base_url("dishes/".$item["id"]."/link?action=1&rid=".$item1["rid"]),$item1["rname"])."</li>";
                    }                    
                    ?>
                </ul>
            </div>
            <div class="col-md-4">可选分类<br>
                <ul><?php
                    if ($links1) foreach ($links1 as $item2) {
                        echo "<li>".anchor(base_url("dishes/".$item["id"]."/link?action=0&rid=".$item2["id"]."&rname=".$item2["name"]),$item2["name"])."</li>";
                    }                    
                    ?>
                </ul>                
            </div>
        </div></div>
    </div>
    <?php if ($item["dtype"]==0): ?>
    <div class="panel panel-default">
        <div class="panel-heading">加入套餐</div>
        <div class="panel-body">
        <div class="row">
            <div class="col-md-4">已属套餐<br>
                <ul><?php
                    if ($links2) foreach ($links2 as $item3) {
                        echo "<li>".anchor(base_url("dishes/".$item["id"]."/link?action=3&rid=".$item3["rid"]),$item3["rname"])."</li>";
                    }                    
                    ?>
                </ul>
            </div>
            <div class="col-md-4">可选套餐<br>
                <ul><?php
                    if ($links3) foreach ($links3 as $item4) {
                        echo "<li>".anchor(base_url("dishes/".$item["id"]."/link?action=2&rid=".$item4["id"]."&rname=".$item4["name"]),$item4["name"])."</li>";
                    }                    
                    ?>
                </ul>                
            </div>
        </div></div>
    </div>
    <?php endif ?>

    <?php
        zm_btn_delete("删 除","confirm_del(\"".$item["id"]."/jdelete\",\"".$item["name"]."\")");
        zm_btn_back("dishes");
    ?>
</div>

<?php zm_dlg_delete(array("path"=> base_url("dishes/"),
                  "title1"  => "确认删除菜品信息",
                  "title2"  => "菜品: ")); ?>