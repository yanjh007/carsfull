<div class="container">
    <div class="page-header">
      <h1>用户管理 <small><?php echo $user["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑用户</div>
        <div class="panel-body">
            <?php
                echo form_open('users/save',array('class' => 'form-horizontal', 'role' => 'form')); 
                echo form_hidden('item_id', $user["id"]);
                zm_form_input(0,"登录名","login",  $user["login"]);
                zm_form_input(0,"显示名","name",   $user["name"]);
                zm_form_input(0,"手 机","mobile",  $user["mobile"]);
                zm_form_select(0,"店 铺","shop",$shops,$shop_select);
                zm_form_textarea(0,"地 址","address",  $user["address"]);
                zm_form_radio(0,"角 色","role", $roles,$user["role"]);                
            ?>
 
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>                
              </div>
            </div>
          </form>
        </div>
    </div>
    
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">修改密码</div>
        <div class="panel-body">
            <?php
                echo form_open('users/savepwd',array('class' => 'form-horizontal', 'role' => 'form',"id"=>"fm_passwd"));
                zm_form_input(0,"密 码","hash", "");
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button class="btn btn-default" type="button" onclick="javascript:randString()">生 成</button>&nbsp&nbsp&nbsp
                <button type="submit" class="btn btn-primary">提 交</button>
                
               </div>
            </div>
        </div>
        <div class="panel-footer">
            系统可以为您生成密码，请记录后，点击保存修改并生效
        </div>
    </div>
    <script type="text/javascript">
        function randString(n) {
           if(!n) n = 5;
       
           var text = '';
           var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
       
           for(var i=0; i < n; i++) {
               text += possible.charAt(Math.floor(Math.random() * possible.length));
           }
                       
           $("#hash").val(text);
       }
       
    </script>
    
    <?php zm_btn_back("'users/'") ?>
</div>

