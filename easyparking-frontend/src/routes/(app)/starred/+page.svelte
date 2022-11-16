<script lang="ts">
  import { user } from '$lib/entities/User';
  import Link from '$lib/shared/ui/Link.svelte';
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
  <title>Favorite parkings</title>
  <meta name="description" content="EasyParking favorite parkings" />
</svelte:head>

<section class="container">
  {#if $user}
    <h1>Welcome, {$user.email.split('@')[0]}, your favorites:</h1>
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
  {:else}
    <h1>login to add favorite parkings</h1>
    <Link to="/login" text="log in" size="l" classNames="btnStyled" />
  {/if}
</section>

<style lang="scss">
  .container {
    width: 60%;
    padding: 30px 10px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    @media (max-width: 1091px) {
      width: 70%;
    }

    @media (max-width: 768px) {
      width: 90%;
      padding: 0;
    }
  }
  h1 {
    font-size: 50px;
    line-height: 58px;
    margin-bottom: 50px;
    text-align: center;
    @media (max-width: 426px) {
      font-size: 30px;
      line-height: 38px;
      margin-bottom: 20px;
    }
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
