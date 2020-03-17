import Axios from 'axios';

export default {
  state: {
    list: {
      entries: [],
      entriesCount: 0,
      userName: null,
      creatable: false
    },
    entry: {},
    error: null
  },
  setEntries(data) {
    this.state.list.entries = this.state.list.entries.concat(data.entries);
    Object.assign(this.state.list, {
      entriesCount: data.entries_count, userName: data.user_name, creatable: data.creatable
    });
  },
  clearEntries() {
    Object.assign(this.state.list, {
      entries: [], entriesCount: 0, userName: null, creatable: false
    });
  },
  getEntries(router, query) {
    let location = { name: 'entries', query: { ...query, format: 'json' } };
    let path = router.resolve(location).href;
    this.state.error = null;

    return new Promise((resolve, reject) => {
      Axios.get(path).then((res) => {
        this.setEntries(res.data);
        resolve(res);
      }).catch((error) =>{
        this.state.error = error;
        reject(error);
      });
    });
  },
  fillTags(srcTags) {
    let tags = [];
    for(let i = 0; i < 5; i++) {
      tags.push(srcTags[i] || { name: '' })
    }
    return tags;
  },
  getEntry(router, entryId, tagFilling) {
    let location = entryId ?
      { name: 'entry', params: { entryId: entryId} } : { name: 'new_entry' };
    location.query = { format: 'json' };
    let path = router.resolve(location).href;
    this.state.error = null;

    return new Promise((resolve, reject) => {
      Axios.get(path).then((res) => {
        this.state.entry = res.data.entry;
        if(tagFilling) {
          this.state.entry.tags = this.fillTags(this.state.entry.tags);
        }
        resolve(res);
      }).catch((error) =>{
        this.state.error = error;
        reject(error);
      });
    });
  },
  clearEntry() {
    this.state.entry = {};
  }
}