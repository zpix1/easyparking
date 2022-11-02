<script>
    import Link from '$lib/shared/ui/Link.svelte';
    import carsHero from '$lib/shared/assets/cars.svg';
    import Navbar from '$lib/widgets/Navbar.svelte';
    import { user } from '$lib/entities/User';
    const links = [
        { page: '/nearby', name: 'nearby parkings' },
        { page: '/starred', name: 'starred' },
        { page: '/login', name: 'log in' },
    ];
</script>

<svelte:head>
    <title>EasyParking</title>
    <meta name="description" content="EasyParking about" />
</svelte:head>

<Navbar {links} />
<main>
    <section class="hero">
        <h1>Discover free parking lots nearby</h1>
        <p>
            With the help of our AI based soluton you no longer need to spend
            time driving around looking for parking vacancy.
        </p>
        <div class="button-wrapper">
            {#if JSON.stringify($user) === '{}'}
                <Link
                    to="/login"
                    text="login"
                    classNames="btnStyled"
                    size="l"
                />
                <Link
                    to="/register"
                    text="register"
                    classNames="btnStyled"
                    size="l"
                />
            {:else}
                <Link
                    to="/starred"
                    text="favorite"
                    classNames="btnStyled"
                    size="l"
                />
            {/if}
        </div>
        <img src={carsHero} alt="cars" />
    </section>
</main>

<style lang="scss">
  main {
    min-width: 100%;
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: var(--navbar-height-desktop) 0 0;
    margin: 0 auto;
  }
  .hero {
    max-width: 100%;
    padding: 50px 200px 100px;
    display: grid;
    grid-template-columns: 1.5fr 1fr;
    grid-template-rows: 1fr 0.3fr 1fr;
    grid-template-areas:
      'title img'
      'descr img'
      'btns img';
    .button-wrapper {
      grid-area: btns;
      display: flex;
      justify-content: space-around;
      width: 100%;
      margin-top: 30px;
    }
    h1 {
      grid-area: title;
      font-size: 96px;
      line-height: 100px;
      width: 100%;
    }
    p {
      grid-area: descr;
      margin-top: 40px;
      font: var(--font-l);
      font-family: var(--font-family-secondary);
    }

    img {
      grid-area: img;
      justify-self: center;
      margin-top: 50px;
      max-width: 100%;
      margin-left: 75px;
    }
  }
  @media (max-width: 1091px) {
    .hero {
      padding: 50px 40px;
      grid-template-columns: 1fr;
      grid-template-rows: 1fr 0.5fr 1fr 1fr;
      grid-template-areas:
        'title'
        'img'
        'descr'
        'btns';
      h1 {
        grid-area: title;
        width: 70%;
        font-size: 48px;
        line-height: 60px;
      }
      p {
        grid-area: descr;
        width: 80%;
        font-size: 25px;
        line-height: 25px;
      }
      .button-wrapper {
        grid-area: btns;
      }
      img {
        grid-area: img;
        justify-self: end;
        max-width: 30%;
        margin-left: 0;
        margin-top: -150px;
      }
    }
  }
  @media (max-width: 768px) {
    .hero {
      img {
        max-width: 40%;
        margin-top: -50px;
      }
    }
  }

  @media (max-width: 500px) {
    .hero {
      padding: 15px;
      grid-template-rows: 0.5fr 1fr 0.5fr 0.5fr;
      h1 {
        width: 100%;
        font-size: 30px;
        line-height: 38px;
        text-align: center;
      }
      p {
        justify-self: center;
        margin-top: 20px;
        font-size: 18px;
        line-height: 26px;
      }
      .button-wrapper {
        margin-top: 0;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        grid-area: btns;
      }
      img {
        grid-area: img;
        justify-self: center;
        max-width: 80%;
        margin-top: 0px;
        margin-left: 0;
      }
    }
  }
</style>
