<script context="module" lang="ts">
  export type ParkingCardStyle = 'light' | 'dark';
</script>

<script lang="ts">
  import { addFavourite, deleteFavourite } from '$lib/entities/UserParking';

  import IconButton from '$lib/shared/ui/IconButton.svelte';
  import { generateMessageFromDate } from '$lib/shared/utils/utils.js';

  export let id: string;
  export let style: ParkingCardStyle;
  export let address: string;
  export let freeLots: number;
  export let updateTime: string;
  export let image: string;
  export let is_favorite: boolean;

  const onClick = () => {
    window.location.href = `/parking/${id}`;
  };
  const toggleFavourite = async (e: MouseEvent) => {
    e.stopPropagation();
    if(is_favorite){
      await deleteFavourite(id);
    } else {
      await addFavourite(id);
    }
    is_favorite = !is_favorite;
  };
</script>

<div
  class="parking-card"
  class:light={style === 'light'}
  class:dark={style === 'dark'}
  on:click={onClick}
>
  <img src={image} width="100px" height="100px" alt="parking" />
  <div class="inner-flex">
    <div class="parking-info-1">
      <div class="address">{address}</div>
      <IconButton icon={`${is_favorite ? 'star-active' : 'star-inactive'}`} onClick={toggleFavourite} />
    </div>
    <div class="parking-info-2">
      <div class="last-updated">{updateTime ? generateMessageFromDate(updateTime) : ''}</div>
      <div class="free-lots">{freeLots ?? '???'} Free lots</div>
    </div>
  </div>
</div>

<style lang="scss">
  .parking-card {
    display: flex;
    flex-flow: row nowrap;
    padding: 1rem;
    column-gap: 1rem;
    border-radius: 10px;
    cursor: pointer;

    &.light {
      background: rgb(89, 82, 112);

      &:hover {
        background: rgb(100, 100, 123);
      }
    }

    &.dark {
      background: rgb(45, 45, 75);
      &:hover {
        background: rgb(56, 56, 86);
      }
    }

    img {
      z-index: 1;
    }
  }

  .inner-flex {
    display: flex;
    flex-flow: column nowrap;
    flex: 1;
    justify-content: space-between;
    cursor: pointer;
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
