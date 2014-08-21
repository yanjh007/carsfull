<div class="container">
    <div class="page-header">
      <h1>店铺管理 <small><?php echo $shop["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑店铺</div>
        <div class="panel-body">
            <?php
                echo form_open('shops/save',array('class' => 'form-horizontal', 'role' => 'form')); 
                echo form_hidden('item_id', $shop["id"]);
                zm_form_input(0,"编 码","login",  $shop["scode"]);
                zm_form_input(0,"名 称","name",   $shop["name"]);
                zm_form_input(0,"联系方式","contact",  $shop["contact"]);
                zm_form_textarea(0,"地 址","address",  $shop["address"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
                <?php zm_btn_back("'shops/'") ?>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>