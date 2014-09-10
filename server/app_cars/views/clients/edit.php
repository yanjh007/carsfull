<div class="container">
    <div class="page-header">
      <h1>客户管理 <small><?php echo $client["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑客户</div>
        <div class="panel-body">
            <?php
                zm_form_open('clients/save',array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_hidden('item_id', $client["id"]);
                zm_form_input(0,"名 称","name",   $client["name"]);
                zm_form_input(0,"手 机","mobile",  $client["mobile"]);
                zm_form_input(0,"IM 方式","wechat",  $client["wechat"]);
                zm_form_textarea(0,"地 址","address",  $client["address"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保 存");
                    zm_btn_back("clients")
                ?>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>