<div class="container">
    <div class="page-header">
      <h1>车型系列 <small><?php echo $item["manufacturer"]."-".$item["brand"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑型号</div>
        <div class="panel-body">
            <?php
                echo form_open("carseries/".$item["id"]."/save",array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_input(0,"厂 商","manufacturer",  $item["manufacturer"]);
                zm_form_input(0,"品 牌","brand",  $item["brand"]);
                zm_form_input(0,"类 型","ctype",   $item["ctype"]);
                zm_form_input(0,"标 签","tags",   $item["tags"]);
                
                zm_form_textarea(0,"基本信息","descp",   $item["descp"]);
                zm_form_input(0,"车系链接","serie_url",   $item["serie_url"]);
                
                zm_form_textarea(0,"引擎列表","engine_list",   $item["engine_list"]);
                zm_form_textarea(0,"变速箱列表","trans_list",   $item["trans_list"]);
                zm_form_input(0,"颜色列表","color_list",   $item["color_list"]);
                
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保 存");
                    zm_btn_delete("删 除","confirm_del(\"".$item["id"]."/delete\",\"".$item["manufacturer"]."-".$item["brand"]."\")");
                    zm_btn_back("carseries");
                ?>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>

<?php zm_dlg_delete(array("path"=> base_url("carseries/"),
                  "title1"  => "确认删除车型信息",
                  "title2"  => "车型: ")); ?>