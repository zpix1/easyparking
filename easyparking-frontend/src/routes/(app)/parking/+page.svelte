<script lang="ts">
  import ParkingCard from '$lib/widgets/ParkingCard.svelte';
  import BackArrowComponent from '$lib/shared/ui/BackArrowComponent.svelte';
  import { getParkingById } from '$lib/entities/UserParking';
  import type { UserParking } from '$lib/entities/UserParking';

  export let parkingId: number;

  getParkingById(parkingId)
    .then(data => {
      parking = data;
    })
    .catch(error => {
      console.error(error);
    });
  let parking: UserParking;
</script>

<svelte:head>
  <title>Parking</title>
  <meta name="description" content="EasyParking nearby parkings around you" />
</svelte:head>

<div class="parking-page">
  <a href="/nearby">
    <div class="parking-link">
      <BackArrowComponent />
      <h1 class="parking-header">All Parkings</h1>
    </div>
  </a>
  {#if parking}
    <ParkingCard
      style={'light'}
      address={parking.parkingAdress}
      freeLots={parking.numEmptySpaces}
      updateTime={parking.updateTime}
      image={parking.parkingImage}
    />
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
