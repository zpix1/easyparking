<script lang="ts">
  import Button from '$lib/shared/ui/Button.svelte';
  import Modal from '$lib/shared/ui/Modal.svelte';
  import IconButton from '$lib/shared/ui/IconButton.svelte';
  import AdminConsoleParkingCreationForm from '$lib/widgets/AdminConsoleParkingCreationForm.svelte';
  import ConfirmationModal from '$lib/widgets/ConfirmationModal.svelte';
  import Loader from '$lib/shared/ui/Loader.svelte';
  import {
    addParking,
    deleteParking,
    editParking,
    getParkings
  } from '$lib/entities/Parking';
  import type { AddParkingPayload } from '$lib/entities/Parking';
  import type { ParkingResponse } from '$lib/entities/Parking';
  import type { gotoFunc } from '../Admin';
  import { isAdmin } from '../Admin';
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';

  onMount(() => {
    if (!isAdmin()) {
      (goto as gotoFunc)('/admin');
    }
    adminChecked = true;
  });

  let parkingsRaw: Array<ParkingResponse>;
  let tableData: TableRowData[] = [];
  let formModalOpen = false;
  let deletionConfirmModalOpen = false;
  let adminChecked = true;
  let onConfirmDeletion = () => {
    deletionConfirmModalOpen = false;
  };
  let onConfirmForm: (body: AddParkingPayload) => void = () => {
    formModalOpen = false;
  };

  void getParkings()
    .then((data: Array<ParkingResponse>) => {
      parkingsRaw = data;
      data.forEach(parking => {
        const newTableData = {
          id: parking.id,
          name: parking.title,
          address: parking.address,
          coordinates: `${parking.latitude}, ${parking.longitude}`,
          creationTime: parking.inserted_at,
          endpoint: parking.camera_endpoint,
          lastUpdate: parking.updated_at
        };
        tableData.push(newTableData);
      });
      tableData = tableData;
    })
    .catch(error => {
      console.log(error);
    });

  interface TableRowData {
    id: string;
    name: string;
    address: string;
    coordinates: string;
    creationTime: string;
    endpoint: string;
    lastUpdate: string;
  }

  const onAddParking = () => {
    formFields.forEach(obj => (obj.value = ''));
    onConfirmForm = (body: AddParkingPayload) => {
      console.log('Hello');
      addParking(body)
        .then((parking: ParkingResponse) => {
          parkingsRaw.push(parking);
          const newTableData = {
            id: parking.id,
            name: parking.title,
            address: parking.address,
            coordinates: `${parking.latitude}, ${parking.longitude}`,
            creationTime: parking.inserted_at,
            endpoint: parking.camera_endpoint,
            lastUpdate: parking.updated_at
          };
          tableData.push(newTableData);
          tableData = tableData;
        })
        .catch(error => {
          console.log(error);
        });
      formModalOpen = false;
    };
    formModalOpen = true;
  };
  const onEditParking = (id: string) => {
    const thisParkingRaw = parkingsRaw.find(parkingRaw => id === parkingRaw.id);
    if (!thisParkingRaw) {
      console.error('NO PARKING ITH SUCH ID');
      return;
    }
    formFields.find(field => field.name === 'title')!.value = thisParkingRaw.title;
    formFields.find(field => field.name === 'address')!.value = thisParkingRaw.address;
    formFields.find(field => field.name === 'latitude')!.value = String(
      thisParkingRaw.latitude
    );
    formFields.find(field => field.name === 'longitude')!.value = String(
      thisParkingRaw.longitude
    );
    formFields.find(field => field.name === 'camera_endpoint')!.value =
      thisParkingRaw.camera_endpoint;

    onConfirmForm = (body: AddParkingPayload) => {
      editParking(id, body)
        .then((parking: ParkingResponse) => {
          const parkingRawId = parkingsRaw.findIndex(
            parkingRaw => parking.id === parkingRaw.id
          );
          parkingsRaw[parkingRawId] = parking;
          const newTableData = {
            id: parking.id,
            name: parking.title,
            address: parking.address,
            coordinates: `${parking.latitude}, ${parking.longitude}`,
            creationTime: parking.inserted_at,
            endpoint: parking.camera_endpoint,
            lastUpdate: parking.updated_at
          };
          const tableDataId = tableData.findIndex(data => data.id === parking.id);
          tableData[tableDataId] = newTableData;
        })
        .catch(error => {
          console.log(error);
        });
      formModalOpen = false;
    };
    formModalOpen = true;
  };
  const onDeleteParking = (id: string) => {
    deletionConfirmModalOpen = true;
    onConfirmDeletion = () => {
      deleteParking(id)
        .then(() => {
          tableData.splice(
            tableData.findIndex(data => data.id === id),
            1
          );
          tableData = tableData;
        })
        .catch(error => {
          console.log(error);
        });
      deletionConfirmModalOpen = false;
    };
  };
  const onCloseForm = () => {
    formModalOpen = false;
  };
  const onCancelDeletion = () => {
    deletionConfirmModalOpen = false;
  };
  let formFields = [
    { name: 'title', type: 'text', value: '' },
    { name: 'address', type: 'text', value: '' },
    { name: 'latitude', type: 'latitude', value: '' },
    { name: 'longitude', type: 'longitude', value: '' },
    { name: 'camera_endpoint', type: 'endpoint', value: '' }
  ];
</script>

<svelte:head>
  <title>EasyParking</title>
  <meta name="description" content="EasyParking about" />
</svelte:head>

<section class="console">
  <div class="content-wrapper">
    {#if !adminChecked}
      <Loader />
    {:else}
      <Modal open={formModalOpen} onCloseCallback={onCloseForm}>
        <AdminConsoleParkingCreationForm
          bind:fields={formFields}
          submitCallback={onConfirmForm}
        />
      </Modal>
      <ConfirmationModal
        open={deletionConfirmModalOpen}
        onClose={onCancelDeletion}
        onConfirm={onConfirmDeletion}
      />
      <div class="head-wrapper">
        <h1 class="console-head">PARKINGS</h1>
        <div class="btn-wrapper">
          <Button onClick={onAddParking}>Add New</Button>
        </div>
      </div>
      <table class="console-table">
        <thead>
          <td>NAME</td>
          <td>ADDRESS</td>
          <td>COORDINATES</td>
          <td>CREATED</td>
          <td>CAMERA ENDPOINT</td>
          <td>LAST UPDATE</td>
          <td />
        </thead>
        {#each tableData as { id, name, address, coordinates, creationTime, endpoint, lastUpdate } (name)}
          <tr>
            <td>{name}</td>
            <td>{address}</td>
            <td>{coordinates}</td>
            <td>{creationTime}</td>
            <td>{endpoint}</td>
            <td>{lastUpdate}</td>
            <td class="console-tools">
              <IconButton onClick={() => onEditParking(id)} icon="pencil" />
              <IconButton onClick={() => onDeleteParking(id)} icon="trash" />
            </td>
          </tr>
        {/each}
        <tr>
          <td />
          <td />
          <td />
          <td />
          <td />
          <td />
          <td />
        </tr>
      </table>
    {/if}
  </div>
</section>

<style lang="scss">
  .console {
    font: var(--font-m);
    display: flex;
    flex-flow: column nowrap;
    flex: 1;
  }

  .content-wrapper {
    margin: 1.5rem;
    display: flex;
    flex-flow: column nowrap;
    flex: 1;
    row-gap: 1rem;

    h1 {
      font: var(--font-l);
      font-weight: normal;
    }
  }

  .head-wrapper {
    display: flex;
    flex-flow: row nowrap;
    flex: 0 1 1%;
    padding-left: 1rem;
    padding-right: 1rem;
    justify-content: space-between;
  }

  .console-head {
    align-self: end;
  }

  .btn-wrapper {
    flex-basis: 15%;
    display: flex;
    flex-flow: row nowrap;
    justify-content: flex-end;
  }

  .console-table {
    display: table;
    flex: 1 1 90%;
    border: rgba(107, 107, 133) 1px solid;
    border-radius: 10px 10px 10px 10px;
    background: rgba(107, 107, 133, 0.5);
    border-spacing: 0;

    thead {
      td {
        border-bottom: rgba(192, 189, 206, 0.5) 1px solid;
      }
    }

    tr:hover {
      background: rgba(140, 140, 166, 0.4);
    }

    tr,
    thead {
      display: table-row;
      td {
        display: table-cell;
        border-right: rgb(192, 189, 206, 0.5) 1px solid;
        padding: 10px;
      }

      td.console-tools {
        display: flex;
        flex-flow: row nowrap;
        column-gap: 0.5rem;
      }

      td:last-child {
        border-right: none;
      }
    }

    tr:last-child {
      display: table-row;
      height: 100%;
      background: rgba(0, 0, 0, 0);
    }
  }
</style>
