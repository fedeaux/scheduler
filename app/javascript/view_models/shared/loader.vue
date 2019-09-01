<template>
  <div class="global-loader" v-if="active">
    <div class="ui active loader"></div>
  </div>
</template>

<script lang="coffee">
  export default
    props: ['active']
</script>
