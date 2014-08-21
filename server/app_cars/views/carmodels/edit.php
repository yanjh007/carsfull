<div class="container">
    <div class="page-header">
      <h1>型号管理 <small><?php echo $carmodel["mcode"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑型号</div>
        <div class="panel-body">
            <?php
                echo form_open('carmodels/save',array('class' => 'form-horizontal', 'role' => 'form'));
                echo form_hidden('item_id', $carmodel["id"]);
                zm_form_input(0,"型号编码","mcode",  $carmodel["mcode"]);
                zm_form_input(0,"名 称","mname",   $carmodel["mname"]);
                zm_form_input(0,"厂商","manufacturer",  $carmodel["manufacturer"]);
                zm_form_input(0,"品牌","brand",  $carmodel["brand"]);
                zm_form_input(0,"类型","ctype",   $carmodel["ctype"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
                <?php zm_btn_back("'carmodels/'") ?>
                
              </div>
            </div>
          </form>
        </div>
    </div>
</div>