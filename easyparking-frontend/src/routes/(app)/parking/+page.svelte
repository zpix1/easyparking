<script lang="ts">
    import ParkingCard from '$lib/widgets/ParkingCard.svelte'
    import BackArrowComponent from '$lib/shared/ui/BackArrowComponent.svelte'

    type ParkingInfo = {
        address: string;
        freeLots: number;
    }

    let parking: ParkingInfo = {
        address: "Pirogova 1",
        freeLots: 15,
    };
</script>

<svelte:head>
    <title>Nearby parkings</title>
    <meta name="description" content="EasyParking nearby parkings around you" />
</svelte:head>

<div class="parking-page">
    <div class="parking-link">
        <BackArrowComponent />
        <h1 class="parking-header">All Parkings</h1>
    </div>
    <ParkingCard
        style={"light"}
        address={parking.address}
        freeLots={parking.freeLots}
    />
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
