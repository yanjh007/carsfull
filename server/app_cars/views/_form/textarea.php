<div class="form-group">
<?php if ($ftype==0): ?>  
  <label class="col-sm-1 control-label"><?php echo $title ?></label>
  <div class="col-sm-6">
  <?php echo form_textarea(array( 'name'  => $name,
                        'id'    => $name,
                        'class' => 'form-control',
                        'value' => $value,
                        'rows'  => "3"
                            )); ?>
  </div>
<?php elseif ($ftype==1): ?>
  <label ><?php echo $title ?></label>
  <?php echo form_textarea(array( 'name'  => $name,
                        'id'    => $name,
                        'class' => 'form-control',
                        'value' => $value,
                        'rows'  => "3"
                            )); ?>
<?php endif ?>
</div>
