<script lang="ts">
  export type IconType = "pencil" | "trash";
  export let icon: IconType;
  export let onClick: (event) => void;
</script>

<button class={icon} on:click={onClick} />

<style lang="scss">
  button {
    width: 32px;
    height: 32px;
    border: none;
    border-radius: 8px;
    background: rgb(162, 162, 175);
    z-index: 1;

    &.pencil {
      background: rgb(162, 162, 175) url('$lib/shared/assets/edit.svg');
    }

    &.trash {
      background: rgb(162, 162, 175) url('$lib/shared/assets/delete.svg');
    }
  }
</style>
