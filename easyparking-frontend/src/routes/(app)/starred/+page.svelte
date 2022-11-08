<script>
  import { user } from "$lib/entities/User";
  import Link from "$lib/shared/ui/Link.svelte";
</script>

<svelte:head>
  <title>Favorite parkings</title>
  <meta name="description" content="EasyParking favorite parkings" />
</svelte:head>

<section class="container">
  {#if $user}
    <h1>Welcome, {$user.email}</h1>
  {:else}
    <h1>login to add favorite parkings</h1>
    <Link to="/login" text="log in" size="l" classNames="btnStyled" />
  {/if}
</section>

<style lang="scss">
  .container {
    width: 50%;
    padding: 50px 10px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  h1 {
    font-size: 50px;
    line-height: 58px;
    margin-bottom: 50px;
  }
</style>
