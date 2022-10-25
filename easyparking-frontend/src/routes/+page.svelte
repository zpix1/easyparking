<script>
    import BackgroundClouds from '$lib/shared/ui/BackgroundClouds.svelte';
    import Button from '$lib/shared/ui/Button.svelte';
    import CarsHero from '../lib/images/cars.svg';
</script>

<svelte:head>
    <title>EasyParking</title>
    <meta name="description" content="EasyParking" />
</svelte:head>

<BackgroundClouds />
<section class="hero">
    <div class="text-wrapper">
        <h1>Discover free parking lots nearby</h1>
        <p>
            With the help of our AI based soluton you no longer need to spend
            time driving around looking for parking vacancy.
        </p>
        <div class="button-wrapper">
            <Button><a href="/login">login</a></Button>
            <Button><a href="/register">register</a></Button>
        </div>
    </div>
    <img src={CarsHero} alt="cars" />
</section>

<style lang="scss">
    .hero {
        padding: 50px 50px 100px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        .text-wrapper {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
        }
        .button-wrapper {
            display: flex;
            justify-content: space-around;
            width: 100%;
            margin-top: 57px;
        }
        h1 {
            font-size: 96px;
            line-height: 100px;
            width: 100%;
        }
        p {
            margin-top: 40px;
            font: var(--font-l);
            font-family: var(--font-family-secondary);
        }
        a {
            text-decoration: none;
            font-weight: 600;
            font: var(--font-l);
            color: var(--color-text);
            text-align: center;
            padding: 26px 80px;
        }
        img {
            max-width: 50%;
            margin-left: 75px;
        }
    }
</style>
