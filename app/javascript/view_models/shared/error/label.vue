<template>
  <div :class="klass">
    {{ message }}
  </div>
</template>

<script lang="coffee">
  export default
    props:
      message:
        default: 'Error!'
      position:
        default: 'below'

    computed:
      klass: ->
        added_klass = "below" if @position == 'above'
        "ui pointing #{added_klass} red label shared-error-label"
</script>
