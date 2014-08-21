<div class="container">
    <div class="page-header">
      <h1>任务类型管理 <small><?php echo $tasktype["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑店铺</div>
        <div class="panel-body">
            <?php
                echo form_open('tasktypes/save',array('class' => 'form-horizontal', 'role' => 'form'));
                echo form_hidden('item_id', $tasktype["id"]);
                zm_form_input(0,"编 码","tcode",  $tasktype["tcode"]);
                zm_form_input(0,"名 称","name",   $tasktype["name"]);
                zm_form_input(0,"时间间隔","duration1",  $tasktype["duration1"]);
                zm_form_input(0,"里程间隔","duration2",  $tasktype["duration2"]);
                zm_form_input(0,"基本工时","tasktime",   $tasktype["tasktime"]);
                zm_form_input(0,"基本费用","taskprice",  $tasktype["taskprice"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
                <?php zm_btn_back("'tasktypes/'") ?>
                
              </div>
            </div>
          </form>
        </div>
    </div>
</div>