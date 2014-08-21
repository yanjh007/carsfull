<div class="form-group">
  <label class="col-sm-1 control-label"><?= $title ?></label>
  <div class="col-sm-6">
  <?= form_textarea(array( 'name'  => $name,
                        'id'    => $name,
                        'class' => 'form-control',
                        'value' => $value,
                        'rows'  => "3"
                            )); ?>
  </div>
</div>
