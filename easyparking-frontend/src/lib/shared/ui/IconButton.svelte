<script lang="ts">
    export type IconType = "pencil" | "trash" | "star";
    export let icon: IconType;
    export let onClick: (event) => void;
</script>

<button class={icon} on:click|stopPropagation={onClick}>
</button>

<style lang="scss">
    button {
        width: 32px;
        height: 32px;
        border: none;
        border-radius: 8px;
        background: rgb(162,162,175);
        z-index: 1;

        &.pencil {
            background: rgb(162,162,175) url("$lib/shared/assets/edit.svg");
        }

        &.trash {
            background: rgb(162,162,175) url("$lib/shared/assets/delete.svg");
        }

        &.star {
          background: rgb(162,162,175) url("$lib/shared/assets/star.svg");

          &:hover {
            background: rgb(190,190,203) url("$lib/shared/assets/star.svg");
          }
        }

    }

</style>