import Axios from 'axios';

export default {
  state: {
    entry: {},
    entries: [],
    entriesCount: 0,
    userName: null,
    myself: false,
    error: null
  },
  getEntries(router, query) {
    let location = { name: 'entries', query: { ...query, format: 'json' } };
    let path = router.resolve(location).href;
    this.state.error = null;

    return new Promise((resolve, reject) => {
      Axios.get(path).then((res) => {
        this.state.entries = this.state.entries.concat(res.data.entries);
        this.state.entriesCount = res.data.entries_count;
        this.state.userName = res.data.user_name;
        this.state.myself = res.data.myself;
        resolve(res);
      }).catch((error) =>{
        this.state.error = error;
        reject(error);
      });
    });
  },
  clearEntries() {
    this.state.entries = [];
    this.state.entriesCount = 0;
    this.state.userName = null;
    this.state.myself = false;
  },
  getEntry(router, entryId) {
    let location = entryId ?
      { name: 'entry', params: { entryId: entryId} } : { name: 'new_entry' };
    location.query = { format: 'json' };
    let path = router.resolve(location).href;
    this.state.error = null;

    return new Promise((resolve, reject) => {
      Axios.get(path).then((res) => {
        this.state.entry = res.data.entry;
        resolve(res);
      }).catch((error) =>{
        this.state.error = error;
        reject(error);
      });
    });
  },
  clearEntry() {
    this.state.entry = {};
    this.state.myself = false;
  }
}