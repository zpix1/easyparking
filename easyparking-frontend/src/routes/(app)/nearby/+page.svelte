<script lang="ts">
  import ParkingListCard from '$lib/widgets/ParkingListCard.svelte';
  import Button from '$lib/shared/ui/Button.svelte';

  type ParkingInfo = {
    address: string;
    freeLots: number;
  };

  const parkingsStep = 5;
  let parkingsActive: ParkingInfo[] = [
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    }
  ];

  const parkings: ParkingInfo[] = [
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    },
    {
      address: 'Pirogova 1',
      freeLots: 15
    }
  ];

  const onShowMore = () => {
    if (parkings.length === parkingsActive.length) {
      return;
    }
    parkingsActive.push(
      ...parkings.slice(parkingsActive.length, parkingsActive.length + parkingsStep)
    );
    parkingsActive = parkingsActive;
  };
</script>

<svelte:head>
  <title>Nearby parkings</title>
  <meta name="description" content="EasyParking nearby parkings around you" />
</svelte:head>

<div class="nearby-page">
  <input class="parkings-input" placeholder="Search parking" />
  <div class="parkings-header">Nearby Parkings</div>
  <div class="parkings-list">
    {#each parkingsActive as parking, i}
      <ParkingListCard
        style={i % 2 === 0 ? 'light' : 'dark'}
        address={parking.address}
        freeLots={parking.freeLots}
      />
    {/each}
  </div>
  {#if parkings.length !== parkingsActive.length}
    <div class="btn-wrapper">
      <Button onClick={() => onShowMore()} size="xl" classNames="mb-50">Load More</Button>
    </div>
  {/if}
</div>

<style lang="scss">
  .nearby-page {
    display: flex;
    flex-flow: column nowrap;
    width: 60%;
    padding: 3rem;
    align-self: center;

    @media (max-width: 1091px) {
      width: 70%;
    }

    @media (max-width: 768px) {
      width: 90%;
      padding: 0;
    }
  }

  .parkings-input {
    width: 50%;
    align-self: center;
    border-radius: 10px;
    padding: 0.5rem 1.5rem;
    margin-bottom: 1rem;
    background: rgba(217, 217, 217, 0.7);
    font: var(--font-l);
    transition: all 0.5s;
    &:focus {
      outline: 3px solid var(--primary-color);
      filter: drop-shadow(2px 2px 5px #a09ef0) drop-shadow(-2px -2px 5px #831dd6);
    }
  }

  .parkings-header {
    margin-bottom: 1rem;
    font: var(--font-xl);
    font-weight: bold;
  }

  .parkings-list {
    display: flex;
    flex-flow: column nowrap;
    align-self: center;
    row-gap: 1rem;
    width: 100%;
    margin-bottom: 1rem;
  }

  .btn-wrapper {
    display: flex;
    flex-flow: row nowrap;
    justify-content: center;
    align-self: center;
    width: 100%;
  }
</style>
