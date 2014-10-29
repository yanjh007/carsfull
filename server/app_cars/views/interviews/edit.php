<div class="container">
    <div class="page-header">
      <h1>测试答题<small><?php ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><?php echo $item["content"] ?></div>
        <div class="panel-body">
            <?php
                zm_form_open(0,"interviews/".$item["eorder"]."/save");
                zm_form_textarea(0,"简 答","answer",isset($answer["answer"])?$answer["answer"]:"");
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保 存");
                    zm_btn_submit("保存->下一题");
                    zm_btn_back("interviews/0/view");
                ?>
              </div>
            </div>
          </form>
        </div>
        
</div>
