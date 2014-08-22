<div class="container">
    <div class="page-header">
      <h1>车辆管理 <small><?php echo $car["carnumber"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑车辆</div>
        <div class="panel-body">
            <?php
                zm_form_open('cars/save',array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_hidden('item_id', $car["id"]);
                zm_form_input(0,"车牌号码","carnumber",  $car["carnumber"]);
                zm_form_textarea(0,"说明信息","descp",  $car["descp"]);
            ?>
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保 存");
                    zm_btn_delete("删 除");
                    zm_btn_back("cars");
                ?>
              </div>            
            </div>
          </form>
        </div>
    </div>
</div>