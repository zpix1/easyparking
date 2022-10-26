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
    <h1>Discover free parking lots nearby</h1>
    <p>
        With the help of our AI based soluton you no longer need to spend time
        driving around looking for parking vacancy.
    </p>
    <div class="button-wrapper">
        <Button><a href="/login">login</a></Button>
        <Button><a href="/register">register</a></Button>
    </div>
    <img src={CarsHero} alt="cars" />
</section>

<style lang="scss">
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
            a {
                text-decoration: none;
                font-weight: 600;
                font: var(--font-l);
                color: var(--color-text);
                text-align: center;
                padding: 26px 60px;
            }
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
                a {
                    padding: 26px 50px;
                }
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
</style>
