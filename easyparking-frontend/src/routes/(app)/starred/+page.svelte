<script lang="ts">
  import { user } from '$lib/entities/User';
  import Link from '$lib/shared/ui/Link.svelte';
  import ParkingListCard from '$lib/widgets/ParkingListCard.svelte';
  import Button from '$lib/shared/ui/Button.svelte';
  import { getFavourite, type UserParking } from '$lib/entities/UserParking';

  const parkingsStep = 5;
  let isFavorite = true;
  let parkingsActive: UserParking[] = [];
  let parkings: UserParking[] = [];
  getFavourite()
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
          id={parking.id}
          updateTime={parking.updated_at}
          image={parking.processed_image_url}
          address={parking.address}
          freeLots={parking.cars_found}
          is_favorite={isFavorite}
        />
      {/each}
    </div>
    {#if parkings.length !== parkingsActive.length}
      <div class="btn-wrapper">
        <Button onClick={() => onShowMore()} size="xl" classNames="mb-50"
          >Load More</Button
        >
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
