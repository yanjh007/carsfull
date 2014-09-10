<div class="container">
    <div class="page-header">
      <h1>单品编辑 <small><?php echo $item["name"]; ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">基本信息</div>
        <div class="panel-body">
            <?php
                echo form_open("dishes/".$item["id"]."/save",array('class' => 'form-horizontal', 'role' => 'form'));
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
                    foreach ($catas1 as $item1) {
                        echo "<li>".anchor(base_url("dishes/".$item["id"]."/unlink?rid=".$item1["rid"]),$item1["rname"])."</li>";
                    }                    
                    ?>
                </ul>
            </div>
            <div class="col-md-4">可选分类<br>
                <ul><?php
                    foreach ($catas2 as $item2) {
                        echo "<li>".anchor(base_url("dishes/".$item["id"]."/link?rid=".$item2["id"]."&rname=".$item2["name"]),$item2["name"])."</li>";
                    }                    
                    ?>
                </ul>                
            </div>
        </div></div>
    </div>
        <?php
            zm_btn_delete("删 除","confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")");
            zm_btn_back("dishes");
        ?>
</div>

<?php zm_dlg_delete(array("path"=> base_url("carseries/"),
                  "title1"  => "确认删除车型信息",
                  "title2"  => "车型: ")); ?>