<script lang="ts">
  import ParkingListCard from '$lib/widgets/ParkingListCard.svelte';
  import Button from '$lib/shared/ui/Button.svelte';
  import { getParkings } from '$lib/entities/UserParking';
  import type { UserParking } from '$lib/entities/UserParking';
    import Loader from '$lib/shared/ui/Loader.svelte';

  const parkingsStep = 5;
  let parkingsActive: UserParking[] = [];
  let parkings: UserParking[] = [];
  getParkings()
    .then(data => {
      parkings = data.entries;
      parkingsActive = parkings.slice(0, parkingsStep);
    })
    .catch(error => {
      console.error(error);
    });

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
  <div class="parkings-header">Nearby Parkings</div>
  {#if parkingsActive}
    <div class="parkings-list">
      {#each parkingsActive as parking, i}
        <ParkingListCard
          style={i % 2 === 0 ? 'light' : 'dark'}
          id={parking.id}
          updateTime={parking.updated_at}
          image={parking.processed_image_url}
          address={parking.address}
          freeLots={parking.cars_found}
          is_favorite={parking.is_favorite}
        />
      {/each}
    </div>
    {#if parkings.length !== parkingsActive.length}
      <div class="btn-wrapper">
        <Button onClick={() => onShowMore()} size="xl" classNames="mb-50">Load More</Button>
      </div>
    {/if}
  {:else}
    <Loader/>
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

  .parkings-header {
    margin-bottom: 1rem;
    font: var(--font-xl);
    font-weight: 900;
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
