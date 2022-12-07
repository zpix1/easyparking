<script lang="ts">
  import { getParkingById, type UserParking } from "$lib/entities/UserParking";
  import BackArrowComponent from "$lib/shared/ui/BackArrowComponent.svelte";
  import ParkingCard from "$lib/widgets/ParkingCard.svelte";
  import Loader from "$lib/shared/ui/Loader.svelte";
  export let data;
  let parking: UserParking;
  getParkingById(data.id)
  .then(data => {
    parking = data;
  })
  .catch(error => {
    console.error(error);
  });
</script>

<svelte:head>
  <title>Parking</title>
  <meta name="description" content="EasyParking nearby parkings around you" />
</svelte:head>

<div class="parking-page">
  <a href="/nearby">
    <div class="parking-link">
      <BackArrowComponent />
    </div>
  </a>
  {#if parking}
    <ParkingCard
      style={'light'}
      id={parking.id}
      address={parking.address}
      freeLots={parking.cars_found}
      updateTime={parking.updated_at}
      image={parking.processed_image_url}
      is_favorite={parking.is_favorite}
    />
  {:else}
   <Loader/>
  {/if}
</div>

<style lang="scss">
  .parking-page {
    display: flex;
    flex-flow: column nowrap;
    row-gap: 2rem;
    width: 55%;
    padding: 3rem;
    align-self: center;

    @media (max-width: 1091px) {
      width: 65%;
    }

    @media (max-width: 768px) {
      width: 75%;
    }
  }

  .parking-link {
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
  }

  .parking-header {
    font-weight: normal;
  }
</style>
