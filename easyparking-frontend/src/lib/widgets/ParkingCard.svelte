<script lang="ts">
  import IconButton from '$lib/shared/ui/IconButton.svelte';
  import { generateMessageFromDate, nop } from '$lib/shared/utils/utils.js';

  type ParkingCardStyle = 'light' | 'dark';

  export let style: ParkingCardStyle;
  export let address: string;
  export let freeLots: number;
  export let updateTime: string;
  export let image: string;
</script>

<div class="parking-card" class:light={style === 'light'} class:dark={style === 'dark'}>
  <div class="inner-flex">
    <div class="parking-info-1">
      <div class="address">{address}</div>
      <IconButton icon="star-inactive" onClick={nop} />
    </div>
    <div class="parking-info-2">
      <div class="last-updated">{generateMessageFromDate(updateTime)}</div>
      <div class="free-lots">{freeLots} Free lots</div>
    </div>
  </div>
  <img src={image} alt="parking" />
</div>

<style lang="scss">
  .parking-card {
    display: flex;
    flex-flow: column nowrap;
    padding: 1rem;
    row-gap: 1rem;
    border-radius: 10px;
    max-height: 50vh;

    &.light {
      background: rgb(89, 82, 112);
    }

    &.dark {
      background: rgb(45, 45, 75);
    }

    img {
      z-index: 1;
      min-height: 0;
    }
  }

  .inner-flex {
    display: flex;
    flex-flow: column nowrap;
    flex: 1;
    justify-content: space-between;
  }

  .parking-info-1 {
    display: flex;
    flex-flow: row nowrap;
    justify-content: space-between;
  }

  .parking-info-2 {
    display: flex;
    flex-flow: row nowrap;
    justify-content: space-between;
    align-items: flex-end;
    column-gap: 1rem;
  }

  .last-updated {
    font: var(--font-s);
  }

  .address {
    font: var(--font-l);
  }

  .free-lots {
    font: var(--font-l);
    font-weight: 600;
  }
</style>
